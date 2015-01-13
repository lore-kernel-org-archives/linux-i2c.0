From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH] i2c: designware: use {readl|writel}_relaxed instead of
 readl/writel
Date: Tue, 13 Jan 2015 18:28:12 +0200
Message-ID: <20150113162812.GA2227@tarshish>
References: <1418279201-3886-1-git-send-email-jszhang@marvell.com>
 <20150113143654.GG7660@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150113143654.GG7660@katana>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jisheng Zhang <jszhang@marvell.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On Tue, Jan 13, 2015 at 03:36:54PM +0100, Wolfram Sang wrote:
> > The driver does not perform DMA, so it's safe to use the relaxed version.
> > From another side, the relaxed io accessor macros are available on all
> > architectures now, so we can use the relaxed versions instead.
> 
> Can the designware core make use of DMA in theory?

According to the "DesignWare DW_apb_i2c Databook" version I have it can 
(optionally).

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
