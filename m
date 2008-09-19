From: Luca Santini <luca.santini-wNesuFfO2Ajz1n+OaKNE4w@public.gmane.org>
Subject: tvp5150 new style i2c driver
Date: Fri, 19 Sep 2008 17:27:10 +0200
Message-ID: <48D3C4CE.80404@spesonline.com>
References: <697640.78220.qm@web95212.mail.in2.yahoo.com>
	<20080919144231.780fb37a@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080919144231.780fb37a-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,
i need to interface with a TI tvp5150 (video codec), wired via i2c on my custom board.

i'm on kernel 2.6.27git and i found there's a driver for the codec... but i get the 'SMBus not supported' error when i try to enable it. So old style coding...
I was trying to convert it to new-style when i found on the ML Archive someone had some similar problem....

do somebody have some pre-coded patch for me? 


After i made it work, how to communicate with it?



thanks,
Luca Santini


p.s. i have no idea how previous post fallen into the wrong thread !


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
