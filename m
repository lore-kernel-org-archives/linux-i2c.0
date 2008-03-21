From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] More DDR2 data for decode-dimms.pl
Date: Fri, 21 Mar 2008 18:47:47 +0100
Message-ID: <20080321184747.3d52ebc3@hyperion.delvare>
References: <Pine.LNX.4.58.0802281401020.14140@shell4.speakeasy.net>
	<20080319141609.338c19b1@hyperion.delvare>
	<Pine.LNX.4.58.0803191731500.16142@shell2.speakeasy.net>
	<20080320121336.2109d6d3@hyperion.delvare>
	<Pine.LNX.4.58.0803200822100.16142@shell2.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0803200822100.16142-nuiHJn5p267P3RPoUHIrnuTW4wlIGRCZ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Trent Piepho <xyzzy-zY4eFNvK5D+xbKUeIHjxjQ@public.gmane.org>
Cc: Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Trent,

On Thu, 20 Mar 2008 08:47:20 -0700 (PDT), Trent Piepho wrote:
> This lets decode-dimms.pl decode almost all of the SPD data for DDR2 dimms.
> Included are all the detailed timing parameters with their standard tXXX
> names, useful if one is trying to program a DDR memory controller for
> example.  Or just to compare against any other SPD dump or memory spec
> sheet.
> 
> ---
> Index: eeprom/decode-dimms.pl
> ===================================================================
> --- eeprom/decode-dimms.pl	(revision 5151)
> +++ eeprom/decode-dimms.pl	(working copy)

<snip>

Patch applied, thanks.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
