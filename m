From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: Add generic I2C multiplexer using pinctrl API
Date: Tue, 17 Apr 2012 21:50:02 +0200
Message-ID: <CACRpkdbqE7H7Q1xUeFQL3DmgoKF6HNbWp-DswYKqMVK12tVSVw@mail.gmail.com>
References: <1334688545-8465-1-git-send-email-swarren@wwwdotorg.org>
 <1334688545-8465-2-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1334688545-8465-2-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Apr 17, 2012 at 8:49 PM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wro=
te:

> This is useful for SoCs whose I2C module's signals can be routed to
> different sets of pins at run-time, using the pinctrl API.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +-----+ =
=A0+-----+
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | dev | =
=A0| dev |
> =A0 =A0+------------------------+ =A0 +-----+ =A0+-----+
> =A0 =A0| SoC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0 =A0| =A0 =
=A0 =A0 =A0|
> =A0 =A0| =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /----|------+--------+
> =A0 =A0| =A0 +---+ =A0 +------+ =A0 =A0 | child bus A, on first set of pi=
ns
> =A0 =A0| =A0 |I2C|---|Pinmux| =A0 =A0 |
> =A0 =A0| =A0 +---+ =A0 +------+ =A0 =A0 | child bus B, on second set of p=
ins
> =A0 =A0| =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \----|------+--------+------=
--+
> =A0 =A0| =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0 =A0| =
=A0 =A0 =A0 =A0| =A0 =A0 =A0 =A0|
> =A0 =A0+------------------------+ =A0+-----+ =A0+-----+ =A0+-----+
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| dev | =
=A0| dev | =A0| dev |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+-----+ =
=A0+-----+ =A0+-----+
>
> Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

I remember you told me about this thing, it's really fascinating!
Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

> Note: This patch depends on the latest pinctrl tree. In order to merge
> this series into the I2C tree, you'll need to merge the pinctrl tree
> into it first. However, the pinctrl tree doesn't yet have a stable tag/br=
anch
> that you can merge, so this patch can't actually be committed yet.

I'll create a tag once I have the devm* stuff in place (it's so
good we just have to have it).

BTW another way is to have this ACK:ed by Jean/Dooks/Wolfram
and I just put it in the pinctrl tree, unless there is something
radical happening in the mux part of the I2C tree this merge
window?

Yours,
Linus Walleij
