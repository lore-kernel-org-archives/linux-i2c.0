From: Jun Gao <jun.gao@mediatek.com>
Subject: Re: [PATCH v3 1/2] i2c: mediatek: Register i2c adapter driver
 earlier
Date: Tue, 11 Sep 2018 10:26:32 +0800
Message-ID: <1536632792.22101.7.camel@mhfsdcap03>
References: <1536239729-10008-1-git-send-email-jun.gao@mediatek.com>
         <1536239729-10008-2-git-send-email-jun.gao@mediatek.com>
         <20180906183144.GD8607@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180906183144.GD8607@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: srv_heupstream@mediatek.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 2018-09-06 at 20:31 +0200, Wolfram Sang wrote:
> On Thu, Sep 06, 2018 at 09:15:28PM +0800, Jun Gao wrote:
> > From: Jun Gao <jun.gao@mediatek.com>
> > 
> > In order not to block the initializations of some i2c devices.
> > Register i2c adapter driver at appropriate time.
> > 
> > Signed-off-by: Jun Gao <jun.gao@mediatek.com>
> 
> The reasons this patch was rejected in v2 still hold.
OK. Thanks for your opinion.
> 
