package Framework
{
	public class FGroup extends FObject
	{

		public var members:Array;
		public var length:int;

		protected var _maxSize:uint;

		public function FGroup(maxSize:uint = 0)
		{
			members = new Array();
			_maxSize = maxSize;

			super();

			draws = true;
		}

		/*
		// Adds the given FObject to the group by first attempting to
		// add the object to an empty spot in members, but, failing that,
		// will push the object onto the end of the list.
		*/
		public function Add(o:FObject):FObject
		{

			// Don't need to add the same object twice
			if(members.indexOf(o) >= 0)
				return o;

			// Search for an empty space in the group to place the new object in
			var i:uint;
			var l:uint = members.length;
			while(i < l)
			{
				if(members[i] == null)
				{
					members[i] = o;
					addChild(o);
					if(i >= length)
						length = i + 1;
					return o;
				}
				i++;
			}

			// If there's no null spot, make room and add our object
			if(_maxSize > 0)
			{
				if(members.length >= _maxSize)
					return o;
				else if(members.length * 2 <= _maxSize)
					members.length *= 2;
				else
					members.length = _maxSize;
			}
			else
			{
				members.length *= 2;
			}

			addChild(o);
			members[i] = o;
			length = i + 1;
			return o;
		}

		public function Remove(o:FObject, Splice:Boolean = false):FObject
		{
			if(o != null)
			{
				var i:int = members.indexOf(o);
				
				// If member doesn't exist, we're done
				if(i < 0 || i >= members.length)
					return null;

				// Remove the sprite from being displayed in the group
				removeChild(o);

				// Either splice it (expensive) or just set obj to null
				if(Splice)
				{
					members.splice(i, 1);
					length--;
				}
				else
				{
					members[i] = null
				}

				return o;
			}
			else
			{
				return null;
			}
		}


		override public function Destroy():void
		{
			for(var i:int = members.length - 1; i >= 0; i--)
			{
				if(members[i] != null)
				{
					Remove(members[i]).Destroy();
				}
			}
		}

		override public function Update():void
		{
			super.Update();
			
			if(!paused && thinks)
			{
				for each(var o:FObject in members)
				{
					if(o != null && o.exists && o.thinks)
					{
						o.Update();
					}
				}
			}
		}

		override public function Draw():void
		{
			if(!paused)
			{
				for each(var o:FObject in members)
				{
					if(o != null && o.draws && o.exists)
						o.Draw();
				}
			}
		}

		// To-do: Implement maxSize recycling handling
		public function Recycle(ObjectClass:Class = null):FObject
		{
			var o:FObject = getFirstAvailable(ObjectClass);
			
			if(o != null)
				return o;
			else if(ObjectClass == null)
				return null;

			return Add(new ObjectClass() as FObject);

		}

		private function getFirstAvailable(ObjectClass:Class = null):FObject
		{
			var o:FObject;
			var i:uint = 0;

			while(i < length)
			{
				o = members[i++] as FObject;

				// Things in () must be encased for some reason. Don't change.
				if(o != null && !o.exists && ((ObjectClass == null) || (o is ObjectClass)))
					return o;
			}

			return null;
		}

		public function Pause():void { paused = true; }
		public function Unpause():void { paused = false; }
		public function TogglePause():void { paused = !paused; }

	}
}