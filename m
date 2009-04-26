From: Krzysztof Helt <krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] i2c: Do not probe for TV chips on Voodoo3 adapters
Date: Sun, 26 Apr 2009 17:25:56 +0200
Message-ID: <20090426172556.be081ae7.krzysztof.h1@poczta.fm>
References: <20090425172708.0622f5b3@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090425172708.0622f5b3-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, 25 Apr 2009 17:27:08 +0200
Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:

> There's no point in giving the I2C bus of Voodoo3 adapters a class
> value, there's no video chip driver checking for it anymore. If
> support is ever needed, the video device should be instantiated
> explicitly rather than probed.
> 
> To the best of my knowledge the only video chip that can be found on
> these boards is a BT869 video encoder, for which no support exists
> currently.
> 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>
> ---


Acked-by: Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>

Wygraj lot balonem dla dwoch osob!
Wejdz >> http://link.interia.pl/f2141 
