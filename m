From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH 07/12] i2c: rk3x: account for const type of of_device_id.data
Date: Wed, 17 Jan 2018 12:00:01 +0100
Message-ID: <9191715.Ndy7U9z6f6@phil>
References: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr> <1514899688-27844-8-git-send-email-Julia.Lawall@lip6.fr> <20180115182456.zkx2ehdlxzrc2scu@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:57680 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752642AbeAQLAY (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 17 Jan 2018 06:00:24 -0500
In-Reply-To: <20180115182456.zkx2ehdlxzrc2scu@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Am Montag, 15. Januar 2018, 19:24:56 CET schrieb Wolfram Sang:
> On Tue, Jan 02, 2018 at 02:28:03PM +0100, Julia Lawall wrote:
> > This driver creates a number of const structures that it stores in
> > the data field of an of_device_id array.
> > 
> > The data field of an of_device_id structure has type const void *, so
> > there is no need for a const-discarding cast when putting const values
> > into such a structure.
> > 
> > Furthermore, adding const to the declaration of the location that
> > receives a const value from such a field ensures that the compiler
> > will continue to check that the value is not modified.  The
> > const-discarding cast on the extraction from the data field is thus
> > no longer needed.
> > 
> > Done using Coccinelle.
> > 
> > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Heiko, you okay with the patch?

Looks good to me and does not seem to contain any changes related
to actual functionality, so
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
