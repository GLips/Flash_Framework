package Framework.Maths
{

	import Framework.Maths.FPoint

	public class FVec
	{
		public function FVec(P1:FPoint = null, P2:FPoint = null)
		{
			if(P1 != null)
				p1 = P1;
			else
				p1 = new FPoint();

			if(P2 != null)
				p2 = P2;
			else
				p2 = new FPoint();
		}
	}
}