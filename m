From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Documentation: devicetree: move trivial-devices out of
 I2C realm
Date: Thu, 16 Mar 2017 15:51:11 -0500
Message-ID: <20170316205111.lpykvpbeaa4mih4n@rob-hp-laptop>
References: <20170306143859.11881-1-wsa@the-dreams.de>
 <20170313075457.GA1431@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170313075457.GA1431@katana>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Mar 13, 2017 at 08:54:57AM +0100, Wolfram Sang wrote:
> On Mon, Mar 06, 2017 at 03:38:59PM +0100, Wolfram Sang wrote:
> > The I2C directory is for I2C master controllers, not for clients. So,
> > move the file describing trivial devices one layer upwards where it
> > fits its generic nature way better.
> > 
> > Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/{i2c => }/trivial-devices.txt | 0
> >  1 file changed, 0 insertions(+), 0 deletions(-)
> >  rename Documentation/devicetree/bindings/{i2c => }/trivial-devices.txt (100%)
> > 
> > diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
> > similarity index 100%
> > rename from Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > rename to Documentation/devicetree/bindings/trivial-devices.txt
> 
> Rob, shall I take it or do you want?

I've applied it.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
