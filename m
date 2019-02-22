From: Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH] i2c: mediatek: modify threshold passed to i2c_get_dma_safe_msg_buf()
Date: Fri, 22 Feb 2019 14:04:11 +0800
Message-ID: <CAJMQK-jzvMBD_AaB7XMJtMqNWiEin25bem4Zo9T5W86Z-U=Tww@mail.gmail.com>
References: <20190215090202.157100-1-hsinyi@chromium.org> <20190215090959.soxkf3ho3or2geme@ninjato>
 <CAJMQK-jrpnfzKNYh01Pg6QydSSa-=6x44Pj1wwMdXw7G3x-ybA@mail.gmail.com>
 <20190215092500.6q3hqnoufyowiqaz@ninjato> <20190215163657.fs6t7p3vqez53su3@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215163657.fs6t7p3vqez53su3@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-arm-kernel@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Jun Gao <jun.gao@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, linux-i2c@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, qii.wang@mediatek.com
List-Id: linux-i2c@vger.kernel.org

Thanks for the solution.
Previously we were testing if the driver can handle zero-length
transfer, but it turns out it will timeout. (Also checked this from
mtk's datasheet)
Adding original owner qii.wang to verify that. We'll apply this after
verification.

On Sat, Feb 16, 2019 at 12:36 AM Wolfram Sang <wsa@the-dreams.de> wrote:
>
>
> >> > Ok, I can add a check in another patch. Should we return NULL pointer
> >> > if msg->len is 0 or print out some warnings? Thanks.
> >>
> >> No warning, msg->len == 0 is a valid setting. But interesting question:
> >> I was about to say NULL, but your driver would assume ENOMEM there and
> >> discard the message which is also not correct since msg->len == 0 is a
> >> valid setting. So, should we just return msg->buf then? Will this work
> >> with your driver? Can it handle zero-length transfers?
> >
> > dma_map_single(i2c->dev, msg->buf , msgs->len, DMA_TO_DEVICE); breaks
> > kernel if msgs->len is 0, so I think it doesn't handle zero-length transfer.
>
> Please don't drop the lists.
>
> Then, the correct solution is to forbid those transfer with this
> controller. Check I2C_AQ_NO_ZERO_LEN. Also, update the functionality
> like this .. (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK).
>
