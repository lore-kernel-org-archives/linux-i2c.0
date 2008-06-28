From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 3/4] i2c: Drop legacy f75375s driver
Date: Sat, 28 Jun 2008 20:58:13 +0200
Message-ID: <20080628205813.152e5ee2@hyperion.delvare>
References: <20080606145212.76f95d52@hyperion.delvare>
	<20080606160957.2ea712bb@hyperion.delvare>
	<54597.80.222.166.80.1214678761.squirrel@webmail.movial.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <54597.80.222.166.80.1214678761.squirrel-2RFepEojUI1aBRb7xItgy/UpdFzICT1y@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Voipio Riku <Riku.Voipio-WgUW+8SLYMv1KXRcyAk9cg@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, 28 Jun 2008 21:46:01 +0300 (EEST), Voipio Riku wrote:
> Hi,
> 
> Tested with the following patchset:
> 
> i2c-use-class_for_each_device.patch
> i2c-simplify-i2c_del_driver.patch
> i2c-core-add-detection-capability-to-new-style-drivers.patch
> hwmon-f75375s-drop-legacy-driver.patch
> 
> and f75375s still works mighty fine when probed new-style. The rtc and led
> drivers (both new-style) attached to i2c bus work too.
> 
> Acked-by: Riku Voipio <riku.voipio-WgUW+8SLYMv1KXRcyAk9cg@public.gmane.org>

Great, thanks for testing Riku!

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
