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


		/**********************
		*
		* INSTANTIATION
		*
		**********************/
		public function FSound()
		{
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