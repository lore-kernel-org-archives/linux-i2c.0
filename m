From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Read SPD data from a hexdump (take 2)
Date: Mon, 24 Mar 2008 11:28:00 +0100
Message-ID: <20080324112800.1782ef78@hyperion.delvare>
References: <Pine.LNX.4.58.0803161427360.20723@shell4.speakeasy.net>
	<20080322150222.2a8ccc60@hyperion.delvare>
	<Pine.LNX.4.58.0803221346450.16142@shell2.speakeasy.net>
	<20080323130547.538eed81@hyperion.delvare>
	<Pine.LNX.4.58.0803231252590.16142@shell2.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0803231252590.16142-nuiHJn5p267P3RPoUHIrnuTW4wlIGRCZ@public.gmane.org>
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
Cc: i2c list <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Trent,

On Sun, 23 Mar 2008 13:46:38 -0700 (PDT), Trent Piepho wrote:
> This adds a "-x" option to decode_dimms.pl, which lets one supply a list of
> file names to read SPD data from.  It can parse various hexdump formats, such
> as the output from i2cdump, eeprog, and the util-linux and Busybox hexdump
> progams run on a sysfs eeprom file.
> 
> Useful for decoding SPD data that you cut and pasted from a manufacturer's
> website or from a DIMM installed on an embeded system that does not have
> perl/etc, but does have a serial console with busybox.
> 
> ---
> Index: eeprom/decode-dimms.pl
> ===================================================================
> --- eeprom/decode-dimms.pl	(revision 5156)
> +++ eeprom/decode-dimms.pl	(working copy)
> (...)

Patch applied, thanks for your contribution.

If you intend to work more on decode-dimms.pl or anything else in the
i2c-tools package, and would like write access to the SVN repository,
please let me know.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
