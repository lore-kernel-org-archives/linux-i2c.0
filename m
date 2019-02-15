From: Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH] i2c: mediatek: modify threshold passed to i2c_get_dma_safe_msg_buf()
Date: Fri, 15 Feb 2019 17:17:27 +0800
Message-ID: <CAJMQK-jrpnfzKNYh01Pg6QydSSa-=6x44Pj1wwMdXw7G3x-ybA@mail.gmail.com>
References: <20190215090202.157100-1-hsinyi@chromium.org> <20190215090959.soxkf3ho3or2geme@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215090959.soxkf3ho3or2geme@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-arm-kernel@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Jun Gao <jun.gao@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, linux-i2c@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Ok, I can add a check in another patch. Should we return NULL pointer
if msg->len is 0 or print out some warnings? Thanks.

On Fri, Feb 15, 2019 at 5:10 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
> On Fri, Feb 15, 2019 at 05:02:02PM +0800, Hsin-Yi Wang wrote:
> > i2c_get_dma_safe_msg_buf() allocates space based on msg->len. If threshold is
> > 0 and msg->len is also 0, function makes zero-length allocation, which returns
> > a special ZERO_SIZE_PTR instead of a NULL pointer, and this will cause later
> > code to fail. Modify the threshold to > 0 so the function returns NULL pointer.
> >
> > Fixes: fc66b39fe36a ("i2c: mediatek: Use DMA safe buffers for i2c transactions")
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>
> Right. But we need to fix i2c_get_dma_safe_msg_buf(), so it will be
> handled for all callers. Do you want to add a check if msg->len is 0 or
> shall I? Both fine for me.
>
