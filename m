From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH i2c-tools] decode-dimms: correctly check for
 out-of-bounds vendor id
Date: Mon, 1 Jun 2015 08:19:49 +0200
Message-ID: <20150601081949.436f0d3b@endymion.delvare>
References: <1432983812-7975-1-git-send-email-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432983812-7975-1-git-send-email-lkundrak-NGH9Lh4a5iE@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Lubomir,

On Sat, 30 May 2015 13:03:32 +0200, Lubomir Rintel wrote:
> ---
>  eeprom/decode-dimms | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/eeprom/decode-dimms b/eeprom/decode-dimms
> index 3a50c07..4a861bd 100755
> --- a/eeprom/decode-dimms
> +++ b/eeprom/decode-dimms
> @@ -345,7 +345,7 @@ sub manufacturer_ddr3($$)
>  	my $manufacturer;
>  
>  	return "Invalid" if parity($code) != 1;
> -	return "Unknown" if ($code & 0x7F) - 1 > $vendors[$count & 0x7F];
> +	return "Unknown" if ($code & 0x7F) > @{$vendors[$count & 0x7F]};
>  	$manufacturer = $vendors[$count & 0x7F][($code & 0x7F) - 1];
>  	$manufacturer =~ s/ \(former .*\)$// if $opt_side_by_side;
>  	$manufacturer .= "? (Invalid parity)" if parity($count) != 1;

Good catch, not sure how we managed to not notice this bug for years
despite the surrounding code being modified several times. Did you find
it by code inspection or did you actually hit the bug on one of your
memory modules?

Note that I would prefer
	... if ($code & 0x7F) - 1 >= @{$vendors[$count & 0x7F]};
It is equivalent but more obviously correct as it matches the array
access on the following line.

Also, even after your fix, I think the code is not completely safe, as
we still don't check for ($code & 0x7F) being 0, nor do we verify that
$count & 0x7F does not exceed the number of elements in @vendors. I'll
fix that.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
