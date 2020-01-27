From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH][next][V2] i2c: xiic: fix indentation issue
Date: Mon, 27 Jan 2020 12:11:43 +0100
Message-ID: <20200127111143.GM8375@localhost>
References: <20200127102303.44133-1-colin.king@canonical.com>
 <2dd84ab2-a7a3-fdd8-6bd6-07f1b3d5cd00@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <2dd84ab2-a7a3-fdd8-6bd6-07f1b3d5cd00@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: Colin King <colin.king@canonical.com>, kernel-janitors@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jan 27, 2020 at 12:03:02PM +0100, Michal Simek wrote:
> On 27. 01. 20 11:23, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > There is a statement that is indented one level too deeply, remove
> > the extraneous tab.
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> > V2: fix type in commit message
> > ---
> >  drivers/i2c/busses/i2c-xiic.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
> > index b17d30c9ab40..90c1c362394d 100644
> > --- a/drivers/i2c/busses/i2c-xiic.c
> > +++ b/drivers/i2c/busses/i2c-xiic.c
> > @@ -261,7 +261,7 @@ static int xiic_clear_rx_fifo(struct xiic_i2c *i2c)
> >  		xiic_getreg8(i2c, XIIC_DRR_REG_OFFSET);
> >  		if (time_after(jiffies, timeout)) {
> >  			dev_err(i2c->dev, "Failed to clear rx fifo\n");
> > -				return -ETIMEDOUT;
> > +			return -ETIMEDOUT;
> >  		}
> >  	}
> >  
> > 
> 
> As was suggested by Peter you should also add Fixes: <sha1> ("patch
> subject")

Please stop this silliness. This is not a bug fix and does not need a
Fixes tag.

Johan
