From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Read SPD data from a hexdump (take 2)
Date: Thu, 20 Mar 2008 12:33:15 +0100
Message-ID: <20080320123315.648911cd@hyperion.delvare>
References: <Pine.LNX.4.58.0803161427360.20723@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0803161427360.20723-13q4cmjDBaTP3RPoUHIrnuTW4wlIGRCZ@public.gmane.org>
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

On Sun, 16 Mar 2008 14:33:23 -0700 (PDT), Trent Piepho wrote:
> This is updated version of the previous patch.  I realized that I used four
> space indent in the last one.  I changed it to 8, and then mode the hexdump
> reading code to another function as it was getting too indented.  Also, it
> can now understand the format of "eeprog".
> 
> This adds a "-x" option to decode_dimms.pl, which lets one supply a list of
> file names to read SPD data from.  It can parse various hexdump formats,
> such as the output from i2cdump and the util-linux and Busybox hexdump
> progams run on a sysfs eeprom file.
> 
> Useful for decoding SPD data that you cut and pasted from a manufacturer's
> website or from a DIMM installed on an embeded system that does not have
> perl/etc, but does have a serial console with busybox.

FYI, we already have a way to achieve this, using the i2c-stub kernel
driver and the standard i2c tools. For simple cases, the
i2c-stub-from-dump helper script (in the i2c-tools SVN repository [1])
automates almost everything. That's what I used to test your new DDR2
timing decoding code, as my workstation doesn't have DDR2 memory.

The main drawback compared to your approach is that one needs root
access to the development system, but in practice I doubt that this is
a problem. The advantage is that it works without any change to the
application (e.g. decode-dimms) so all applications are supported right
away.

i2c-stub-from-dump is currently limited in the dump format it supports
(it only takes byte and word dumps from i2cdump) but extending it to
support more dump formats would be trivial. We could even extend it to
support binary input.

[1] http://www.lm-sensors.org/browser/i2c-tools/trunk/stub

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
