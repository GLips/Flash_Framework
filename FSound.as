package Framework
{

	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.media.SoundMixer;

	public class FSound
	{

		private var channel1:SoundChannel;
		private var channel2:SoundChannel;
		private var channel3:SoundChannel;

		private var musicChannel:SoundChannel;

		private var _muted:Boolean;
		public function get muted():Boolean { return _muted; }
		public function set muted(m:Boolean):void { _muted = m; if(m == true){ Stop(); } }

		/**********************
		*
		* INSTANTIATION
		*
		**********************/
		public function FSound()
		{
			_muted = false;
		}

		/**********************
		*
		* CLASS SPECIFIC FUNCTIONS
		*
		**********************/
		public function Init():void
		{
			channel1 = new SoundChannel();
		}

		public function Play(snd:Sound):void
		{
			if(!_muted)
				channel1 = snd.play();
		}

		public function Stop():void
		{
			channel1.stop();
		}


		/**********************
		*
		* PRIVATE FUNCTIONS
		*
		**********************/
	}
}