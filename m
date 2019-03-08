From: Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH] i2c: mediatek: modify threshold passed to i2c_get_dma_safe_msg_buf()
Date: Sat, 9 Mar 2019 00:22:35 +0800
Message-ID: <CAJMQK-jRheyFwvKDURF9kxW4MXTQmgQjuGbXjerth26PLF_3dQ@mail.gmail.com>
References: <20190215090202.157100-1-hsinyi@chromium.org> <20190215090959.soxkf3ho3or2geme@ninjato>
 <CAJMQK-jrpnfzKNYh01Pg6QydSSa-=6x44Pj1wwMdXw7G3x-ybA@mail.gmail.com>
 <20190215092500.6q3hqnoufyowiqaz@ninjato> <20190215163657.fs6t7p3vqez53su3@ninjato>
 <CAJMQK-jzvMBD_AaB7XMJtMqNWiEin25bem4Zo9T5W86Z-U=Tww@mail.gmail.com>
 <20190308112919.GA1674@kunai> <CAJMQK-j9b3o+KQfN8nLXGiP+TXi8i77=yTTQsEARa6cotPhxzw@mail.gmail.com>
 <20190308145203.GA4743@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190308145203.GA4743@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-arm-kernel@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Jun Gao <jun.gao@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, linux-i2c@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, qii.wang@mediatek.com
List-Id: linux-i2c@vger.kernel.org

On Fri, Mar 8, 2019 at 10:52 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
>
> > > I just checked this issue again and concluded that both are reasonable,
> > > the suggestion from me below with the adapter quirk AND your original
> > > patch setting the threshold to 1. With my suggestion the core will
> > > prevent 0-length messages. But still, we should set the threshold to 1
> > > because 0 is a value the HW is not capable of.
> > >
> > I think quirk might be better, since mediatek said they might have some ICs
> > that can handle zero-length transfer in the future, so flags might be
> > more clear if they want to restore functionality.
>
> But I guess you don't want to do the zero-length transfer with DMA then?
> With that in mind, raising the threshold still makes sense to me.
>
Yes. Then I think this patch is okay for merge?

And since the mt8183 patches are still under reviewing, we'll upload adapter
quirk patch after those are merged.

Thanks
