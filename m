From: Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH] i2c: mediatek: modify threshold passed to i2c_get_dma_safe_msg_buf()
Date: Fri, 8 Mar 2019 22:39:50 +0800
Message-ID: <CAJMQK-j9b3o+KQfN8nLXGiP+TXi8i77=yTTQsEARa6cotPhxzw@mail.gmail.com>
References: <20190215090202.157100-1-hsinyi@chromium.org> <20190215090959.soxkf3ho3or2geme@ninjato>
 <CAJMQK-jrpnfzKNYh01Pg6QydSSa-=6x44Pj1wwMdXw7G3x-ybA@mail.gmail.com>
 <20190215092500.6q3hqnoufyowiqaz@ninjato> <20190215163657.fs6t7p3vqez53su3@ninjato>
 <CAJMQK-jzvMBD_AaB7XMJtMqNWiEin25bem4Zo9T5W86Z-U=Tww@mail.gmail.com> <20190308112919.GA1674@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190308112919.GA1674@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-arm-kernel@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Jun Gao <jun.gao@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, linux-i2c@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, qii.wang@mediatek.com
List-Id: linux-i2c@vger.kernel.org

On Fri, Mar 8, 2019 at 7:29 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Fri, Feb 22, 2019 at 02:04:11PM +0800, Hsin-Yi Wang wrote:
> > Thanks for the solution.
> > Previously we were testing if the driver can handle zero-length
> > transfer, but it turns out it will timeout. (Also checked this from
> > mtk's datasheet)
> > Adding original owner qii.wang to verify that. We'll apply this after
> > verification.
>
> I just checked this issue again and concluded that both are reasonable,
> the suggestion from me below with the adapter quirk AND your original
> patch setting the threshold to 1. With my suggestion the core will
> prevent 0-length messages. But still, we should set the threshold to 1
> because 0 is a value the HW is not capable of.
>
I think quirk might be better, since mediatek said they might have some ICs
that can handle zero-length transfer in the future, so flags might be
more clear if they want to restore functionality.
> >
> > On Sat, Feb 16, 2019 at 12:36 AM Wolfram Sang <wsa@the-dreams.de> wrote:
> > >
> > >
> > > >> > Ok, I can add a check in another patch. Should we return NULL pointer
> > > >> > if msg->len is 0 or print out some warnings? Thanks.
> > > >>
> > > >> No warning, msg->len == 0 is a valid setting. But interesting question:
> > > >> I was about to say NULL, but your driver would assume ENOMEM there and
> > > >> discard the message which is also not correct since msg->len == 0 is a
> > > >> valid setting. So, should we just return msg->buf then? Will this work
> > > >> with your driver? Can it handle zero-length transfers?
> > > >
> > > > dma_map_single(i2c->dev, msg->buf , msgs->len, DMA_TO_DEVICE); breaks
> > > > kernel if msgs->len is 0, so I think it doesn't handle zero-length transfer.
> > >
> > > Please don't drop the lists.
> > >
> > > Then, the correct solution is to forbid those transfer with this
> > > controller. Check I2C_AQ_NO_ZERO_LEN. Also, update the functionality
> > > like this .. (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK).
> > >
