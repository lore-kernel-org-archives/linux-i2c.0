From: Jun Gao <jun.gao@mediatek.com>
Subject: Re: [PATCH v2 2/2] i2c: mediatek: Add i2c compatible for MediaTek
 MT7622
Date: Mon, 14 Aug 2017 09:36:56 +0800
Message-ID: <1502674616.930.74.camel@mhfsdcap03>
References: <1502506672-7620-1-git-send-email-jun.gao@mediatek.com>
         <1502506672-7620-3-git-send-email-jun.gao@mediatek.com>
         <20170812144411.zqgbncsemzaolldv@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170812144411.zqgbncsemzaolldv@ninjato>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Sat, 2017-08-12 at 16:44 +0200, Wolfram Sang wrote:
> > +static const struct i2c_adapter_quirks mt7622_i2c_quirks = {
> > +	.max_num_msgs = 255,
> > +	.max_write_len = 65535,
> > +	.max_read_len = 65535,
> > +	.max_comb_1st_msg_len = 65535,
> > +	.max_comb_2nd_msg_len = 65535,
> > +};
> 
> That looks like no quirks? Then just leave the quirks pointer below
> empty.
> 
Compare to MT8173 i2c controller, MT7622 limits message numbers to 255.

Jun
