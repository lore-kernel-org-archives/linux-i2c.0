From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 1/1] I2C pxa fast mode (400khz) support
Date: Sat, 12 Jul 2008 14:35:06 -0700
Message-ID: <200807121435.06773.david-b@pacbell.net>
References: <486B9E30.80806@cam.ac.uk> <200807111920.29739.david-b@pacbell.net>
	<48791BF8.8080500@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <48791BF8.8080500-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Troy Kisky <troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org>
Cc: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> >> I think use_pio and fast_mode could both be bits.
> > 
> > Or alternatively, "bool" ... which is usually a byte, and
> > on ARM will let GCC eliminate a comparision instruction.
> > Just load byte and branch on zero/nonzero, vs needing one
> > more instruction.
> 
> Unfortunately, on ARM the LDR/LDRB instructions can not
> update the condition codes.

Right, sorry -- I was looking at MOV not LDRB.

I don't use assembler often enough to remember
that little asymmetry:  data movement involving
memory uses different notations and instructions.

If only the instruction set were as regular as
a PDP-11 ... ;)


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
