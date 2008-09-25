From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: SMBus of Sis650/961 P4 system not recognised
Date: Thu, 25 Sep 2008 10:37:46 +0200
Message-ID: <20080925103746.1f7bd810@hyperion.delvare>
References: <1221391781.31885.22.camel@localhost>
	<20080920134329.5e1b2198@hyperion.delvare>
	<1221928948.32367.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <1221928948.32367.4.camel@localhost>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: subscriptions-EwJsF0SrM7dWk0Htik3J/w@public.gmane.org
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Martin,

Please keep the i2c list Cc'd.

On Sat, 20 Sep 2008 17:42:27 +0100, subscriptions-EwJsF0SrM7dWk0Htik3J/w@public.gmane.org wrote:
> your response is most appreciated. ! However after loading the 12c-dev
> module successfully I cannot run i2cdetect as it seems not to be a part
> of the latest lm-sensors (3.0.2) for 2.6 kernels.
> 
> What should I do to cure the absence of this detection utility ?

i2cdetect is part of the i2c-tools package:
http://www.lm-sensors.org/wiki/I2CTools

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
