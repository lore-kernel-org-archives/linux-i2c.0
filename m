From: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] i2c: ocores: Fix pointer to integer cast warning
Date: Tue, 19 Feb 2013 14:05:01 +0100
Message-ID: <5123787D.3000900@gaisler.com>
References: <1361259199-24709-1-git-send-email-jchandra@broadcom.com> <87liakiu20.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87liakiu20.fsf-D6SC8u56vOOJDPpyT6T3/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Cc: Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On 2013-02-19 09:31, Peter Korsgaard wrote:
>>>>>> "Jayachandran" == Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org> writes:
>
>   Jayachandran> After commit a000b8c1 [i2c: ocores: Add support for the
>   Jayachandran> GRLIB port of the controller and use function pointers
>   Jayachandran> for getreg and setreg function], compiling i2c-ocores.c
>   Jayachandran> for 64-bit gives the following warning:
>
>   Jayachandran>   drivers/i2c/busses/i2c-ocores.c: In function 'ocores_i2c_of_probe':
>   Jayachandran>   drivers/i2c/busses/i2c-ocores.c:334:15: warning: cast from pointer to integer of different size
>
>   Jayachandran> Fix it by casting the pointer to long.
>
> I've CC'ed Andreas who made the change.
>
> Acked-by: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>

Thanks!

Acked-by: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
