From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Read SPD data from a hexdump (take 2)
Date: Sun, 23 Mar 2008 13:05:47 +0100
Message-ID: <20080323130547.538eed81@hyperion.delvare>
References: <Pine.LNX.4.58.0803161427360.20723@shell4.speakeasy.net>
	<20080322150222.2a8ccc60@hyperion.delvare>
	<Pine.LNX.4.58.0803221346450.16142@shell2.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0803221346450.16142-nuiHJn5p267P3RPoUHIrnuTW4wlIGRCZ@public.gmane.org>
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

On Sat, 22 Mar 2008 14:46:43 -0700 (PDT), Trent Piepho wrote:
> On Sat, 22 Mar 2008, Jean Delvare wrote:
> > You repeat the same byte for all the omitted block... this isn't how I
> > read man hexdump(1). As I understand it, you are supposed to repeat the
> > last line, not the last byte.
> >
> > Alternatively you could drop support for this special format, which
> > doesn't make much sense for a 256-byte EEPROM if you ask me. And in
> > practice the only cases where it could happen is for rows of 0x00s or
> > 0xffs - it doesn't make a difference if you omit them completely.
> 
> I've added code to ignore header lines.  The code to parse the repeat line
> syntax is there for the same reason:  hexdump produces that syntax when you
> run it on an eeprom file.  Not parsing it requires editing the hexdumps by
> hand, which is a lot more trouble than just deleting a one line header.

Maybe I did not express myself clearly enough. I didn't mean to stop
supporting the special "compact" format by choking on it, but by
simply ignoring the "*" line as you do for i2cdump's header line (and
filling the @bytes array with zeroes, which would be presumably simpler
than what you did.)

> As far as I can tell, hexdump and od only produce the line repeat when
> every byte in the line is the same, so repeating the last byte vs the last
> 16 bytes is effectively the same.

Your assumption is incorrect. You can test it easily:

khali@hyperion:~> dd if=/dev/random of=random16.bin bs=16 count=1
1+0 records in
1+0 records out
16 bytes (16 B) copied, 6.5427e-05 s, 245 kB/s
khali@hyperion:~> hexdump random16.bin
0000000 9d89 66d7 d2a5 9118 86b9 85c6 9454 cc8e
0000010
khali@hyperion:~> cat random16.bin random16.bin random16.bin random16.bin > random64.bin
khali@hyperion:~> hexdump random64.bin
0000000 9d89 66d7 d2a5 9118 86b9 85c6 9454 cc8e
*
0000040
khali@hyperion:~> od -x random64.bin
0000000 9d89 66d7 d2a5 9118 86b9 85c6 9454 cc8e
*
0000100
khali@hyperion:~>

And I agree that it doesn't make much sense (at least when od's -w
option isn't used) but that's the way it is.

> My goal wasn't to code some complex
> "perfect" hex dump parser, but just to work correctly on the formats one
> typically has at hand.

Fine with me, but either implement the "repeat" mode properly (it
shouldn't be that difficult), or don't implement it at all.
Implementing it in a way which doesn't match what hexdump and od output
doesn't make any sense to me.

> > (...)
> > I'm unsure if we want to support this ambiguous format. You assume
> > big-endian byte order here. Even though you document it in the comment
> > above, users might not read the source code and so might feed the
> > script with little-endian byte order data and get noise out of the
> > script.
> 
> I've added some better documentation to the help output.  It's the default

Good start, but I'd go further and warn the user at runtime when
parsing hexdumps using this format. For example:

Warning: Assuming hexdump uses big-endian byte order

> > (...)
> > In anticipation of more options being added in the future, I'd
> > use !/^-/ instead. Your variant above also fails if long options are
> > used.
> 
> Fixed.  Note that all the option regexes should be changed to something
> like '/^-?-f/'.  Otherwise a filename like hys72d32500gr-7-b will trigger
> the $opt_bodyonly option.  (that's a real example, I named my eeprom dumps
> after the part number, but in caps)

You are correct. Even better would be to explicitly match the short and
long options. I'll fix that later.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
