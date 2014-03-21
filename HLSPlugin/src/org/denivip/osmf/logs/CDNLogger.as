package org.denivip.osmf.logs
{
	import flash.external.ExternalInterface;

	public class CDNLogger
	{
		private static const TWO_MBPS	:String = "Below 2 Mbps";
		private static const FIVE_MBPS	:String = "2 to 5 Mbps";
		private static const OVER_MBPS	:String = "More then 5 Mbps";
		
		public static function getCDNData(size:Number, time:Number):void{
			time = (time == 0) ? .0001 : time;
			size *= 8; // bits
			var speed:Number = (size/1024)/(time); // bits / sec
			var speedMbps:Number = speed/1024;
			
			var sSpeed:String;
			
			if(speedMbps > 5.0)
				sSpeed = OVER_MBPS;
			else if(speedMbps > 2.0 && speedMbps < 5.0)
				sSpeed = FIVE_MBPS;
			else
				sSpeed = TWO_MBPS;
			
			var funcS:String = " _gaq.push([" +
				"'_trackEvent'," +
				" 'CDN', '" +
				"Download" +
				"', '" +
				sSpeed +
				"', " +
				Math.round(speed).toString() + 
				"  ]);";
			
			funcS = "function(){" +
				//"console.log(\"" + 
				//funcS + 
				//"\");" +
				funcS +
				"}";
			
			//trace(funcS);
			try{
				if(ExternalInterface.available)
					ExternalInterface.call(funcS);
					//ExternalInterface.call('gaLog', sSpeed, Math.round(speed).toString()+"Kbps");
			}catch(e:SecurityError){
				trace('shit happens...');
			}
			
			/*
			
			trace();
			*/
		}
	}
}