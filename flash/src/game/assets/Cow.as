package game.assets {

	/**
	 * ...
	 * @author hlavko
	 */
	public class Cow {

		[Embed(source="../../../assets/cow/cow-walk.xml", mimeType="application/octet-stream")]
		static public var AnimData:Class;
		 
		[Embed(source="../../../assets/cow/cow-walk.png")]
		static public var AnimTexture:Class;

	}

}