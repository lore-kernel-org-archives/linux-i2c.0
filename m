From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: AU1550 I2C driver - why not wait for bus free?
Date: Sat, 5 Apr 2008 11:24:09 +0200
Message-ID: <20080405112409.68b6c1a3@hyperion.delvare>
References: <47F3549E.2090500@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <47F3549E.2090500-qv+LCo8X3VpBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Sergei Poselenov <sposelenov-qv+LCo8X3VpBDgjK7y7TUQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Sergei,

On Wed, 02 Apr 2008 13:40:46 +0400, Sergei Poselenov wrote:
> I have a question about AU1550 I2C driver.
> Why the driver starts transfer regardless of the state
> of I2C bus? Shouldn't it wait for the "bus busy" bit
> in smbstat to become zero before setting the
> "master start" bit?
> 
> I see, in the 2.4 version of the driver the above logic
> was present, but avoided in 2.6.

I wasn't aware that there was a 2.4 i2c-au1550 driver... I don't see it
in mainline at least.

Checking for the bus busy bit before starting a transaction sounds like
a good idea, feel free to submit a patch implementing this and we'll
review it.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
