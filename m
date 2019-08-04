From: Sean Young <sean@mess.org>
Subject: Re: [PATCH v2 1/2] media: ir-kbd-i2c: convert to
 i2c_new_dummy_device()
Date: Sun, 4 Aug 2019 03:57:29 +0100
Message-ID: <20190804025728.5v5r42zmjn5onxl7@gofer.mess.org>
References: <20190730175555.14098-1-wsa+renesas@sang-engineering.com>
 <20190730175555.14098-2-wsa+renesas@sang-engineering.com>
 <20190803131749.4d6517ab@coco.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190803131749.4d6517ab@coco.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sat, Aug 03, 2019 at 01:17:49PM -0300, Mauro Carvalho Chehab wrote:
> Em Tue, 30 Jul 2019 19:55:54 +0200
> Wolfram Sang <wsa+renesas@sang-engineering.com> escreveu:
> 
> > Convert this driver to use the new i2c_new_dummy_device() call and bail
> > out if the dummy device cannot be registered to make failure more
> > visible to the user.
> > 
> 
> Please don't do that.
> 
> At first glance, devm_* sounds a good idea, but we had enough issues
> using it on media system.
> 
> I don't mind mind much if some SoC specific would use it, but doing
> it on generic drivers is a very bad idea. We have removed almost all
> devm_* calls from the media system.
> 
> The problem with devm is that it the de-allocation routines aren't
> called during device unbind. They happen a way later, only when the
> device itself is physically removed, or the driver is removed.

Yes, good point.

> That caused lots of headaches to debug memory lifetime issues on
> media.

Indeed this becomes much more complex. Explicit freeing is much better.


Thanks,
Sean
