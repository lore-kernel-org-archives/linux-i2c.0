From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] i2c: qcom-geni: Provide an option to select FIFO
 processing
Date: Wed, 4 Sep 2019 13:18:07 +0100
Message-ID: <20190904121807.GK26880@dell>
References: <20190904113613.14997-1-lee.jones@linaro.org>
 <20190904115609.GW2672@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190904115609.GW2672@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vkoul@kernel.org>
Cc: alokc@codeaurora.org, agross@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, bjorn.andersson@linaro.org, linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 04 Sep 2019, Vinod Koul wrote:

> On 04-09-19, 12:36, Lee Jones wrote:
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/i2c/busses/i2c-qcom-geni.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> > index a89bfce5388e..dfdbce067827 100644
> > --- a/drivers/i2c/busses/i2c-qcom-geni.c
> > +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> > @@ -353,13 +353,16 @@ static void geni_i2c_tx_fsm_rst(struct geni_i2c_dev *gi2c)
> >  static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg *msg,
> >  				u32 m_param)
> >  {
> > +	struct device_node *np = gi2c->se.dev->of_node;
> >  	dma_addr_t rx_dma;
> >  	unsigned long time_left;
> > -	void *dma_buf;
> > +	void *dma_buf = NULL;
> >  	struct geni_se *se = &gi2c->se;
> >  	size_t len = msg->len;
> >  
> > -	dma_buf = i2c_get_dma_safe_msg_buf(msg, 32);
> > +	if (!of_property_read_bool(np, "qcom,geni-se-fifo"))
> 
> Where is this property documented, I dont see anything in linux-next for
> today

In this set. :)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
