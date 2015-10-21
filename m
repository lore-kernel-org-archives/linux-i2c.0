From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] dts: keystone: Use new "ti,keystone-i2c" compatible
Date: Wed, 21 Oct 2015 13:33:42 +0200
Message-ID: <56277816.2080801@nokia.com>
References: <55F68E36.2030609@nokia.com> <20151020150614.GG5379@katana>
 <56266791.5000805@ti.com> <56276565.4060505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56276565.4060505-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: EXT Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi!

On 21/10/15 12:13, EXT Sekhar Nori wrote:
>>>> Now as "i2c-davinci" driver has special handling for Keystone it's
>>>> >>> time to switch
>>>> >>> the device tree to use new "compatible" property. Old one is left for
>>>> >>> backwards-
>>>> >>> compatibility.
>>>> >>>
>>>> >>> Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
>>> >>
>>> >> Shall I take this one or shall it go via the davinci tree?
> I don't have the patch in my mailbox now. But as I remember this is a

You can review it here:
http://patchwork.ozlabs.org/patch/517321/

> driver only patch and should go via i2c tree.

It's a DT change, because we agreed (with Grygorii) that new "compatible" is more
future proof.

-- 
Best regards,
Alexander Sverdlin.
Sent from my pdp-11
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
