From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v2 01/25] nvmem: add new config option
Date: Thu, 29 Nov 2018 15:43:14 +0100
Message-ID: <20181129154314.1d3cd914@bbrezillon>
References: <20181113140133.17385-1-brgl@bgdev.pl>
        <20181113140133.17385-2-brgl@bgdev.pl>
        <CAMRc=MeRJ60gcYz00C828PBqnEdC-9onOKOadfackdzHiC1WOA@mail.gmail.com>
        <b8f08722-d3d5-6ddf-5845-15eb5079094c@linaro.org>
        <CAMRc=Md4PbYDhmBNx5Rk5F9OZw2Om3D6F21iV6za-+dq0NshYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMRc=Md4PbYDhmBNx5Rk5F9OZw2Om3D6F21iV6za-+dq0NshYw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-i2c <linux-i2c@vger.kernel.org>, "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>, Kevin Hilman <khilman@kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Sekhar Nori <nsekhar@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 29 Nov 2018 15:35:58 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> czw., 29 lis 2018 o 15:32 Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> napisał(a):
> >
> >  
> > >
> > > Hi Srinivas,
> > >
> > > if there are no objections - can you Ack this patch for Greg to pick
> > > up into char-misc?  
> >
> > Patch is fine for me. I normally send all the nvmem patches just before rc5.
> >
> > --srini  
> > >
> > > Bart
> > >  
> 
> Boris, are you fine with Srinivas sending the MTD patch as well so
> that they stay together?

Yes, I'll just need an immutable branch/tag in case we have conflicting
changes in the MTD tree.
