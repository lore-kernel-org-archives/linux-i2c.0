From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] More DDR2 data for decode-dimms.pl
Date: Thu, 20 Mar 2008 12:13:36 +0100
Message-ID: <20080320121336.2109d6d3@hyperion.delvare>
References: <Pine.LNX.4.58.0802281401020.14140@shell4.speakeasy.net>
	<20080319141609.338c19b1@hyperion.delvare>
	<Pine.LNX.4.58.0803191731500.16142@shell2.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0803191731500.16142-nuiHJn5p267P3RPoUHIrnuTW4wlIGRCZ@public.gmane.org>
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

On Wed, 19 Mar 2008 18:36:32 -0700 (PDT), Trent Piepho wrote:
> On Wed, 19 Mar 2008, Jean Delvare wrote:
> > As far as I can see, the masking isn't needed, as you do it again in
> > ddrx_sdram_rtime(). That being said, it would probably make sense to do
> > all the shifting and masking on the caller's side. Doing half of the
> > shifting outside and the other half inside the function is pretty
> > confusing.
> 
> This is better?
> 
>         printl "Minimum Active to Auto-refresh Delay (tRC)",
>                tns(ddr2_sdram_rtime($bytes->[41], ($bytes->[40] >> 4) & 7));
>         printl "Minimum Recovery Delay (tRFC)",
>                tns(ddr2_sdram_rtime($bytes->[42] + ($bytes->[40] & 1) * 256,
> 	                            ($bytes->[40] >> 1) & 7));
> 
> I was trying to do as much as possible on the callee's side.

Yes I think it is better. I understand that putting more on the
callee's side performs better and makes the code look better on the
caller's side, but the problem is that the helper function then has an
interface that is obscure and difficult to understand and validate. I
prefer something a bit slower but with a clean interface.

If you want to move some more code in the callee, I propose the
following:

sub ddr2_sdram_rtime($$)
{
	my ($rtime, $ext1, $ext2) = @_;
	my @table = (0, .25, .33, .50, .66, .75);

	return $time + ext1 * 256 + $table[$ext2];
}

(...)
	printl "Minimum Active to Auto-refresh Delay (tRC)",
	       tns(ddr2_sdram_rtime($bytes->[41], 0, ($bytes->[40] >> 4) & 7));
	printl "Minimum Recovery Delay (tRFC)",
	       tns(ddr2_sdram_rtime($bytes->[42], $bytes->[40] & 1,
				    ($bytes->[40] >> 1) & 7));

That's probably the best trade-off you can get.

I'm fine with the rest, with one question though:

> +	my @burst;
> +	push @burst, 4 if ($bytes->[16] & 4);
> +	push @burst, 8 if ($bytes->[16] & 8);
> +	printl "Supported Burst Lengths", join(', ', @burst);

Do DDR2 modules have to support burst at all? The SDR code assumes that
the module might not support any burst length and prints "None" in this
case. I suspect that we should do the same for DDR2.

Thanks,
-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
