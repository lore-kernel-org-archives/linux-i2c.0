From: Yi Zhang <yizhang@mx0a-0016f401.pphosted.com>
Subject: Re: [PATCH 04/12] i2c: pxa: Add support for pxa910/988 & new
 configuration features
Date: Thu, 4 Jun 2015 10:31:46 +0800
Message-ID: <20150604023146.GF6696@yizhang>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1432818224-17070-5-git-send-email-vaibhav.hiremath@linaro.org>
 <874mmvyvzw.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <874mmvyvzw.fsf@belgarion.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: "Jett.Zhou" <jtzhou@marvell.com>, Wolfram Sang <wsa@the-dreams.de>, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, May 29, 2015 at 10:22:27PM +0200, Robert Jarzmik wrote:
> Vaibhav Hiremath <vaibhav.hiremath@linaro.org> writes:
> 
> > @@ -167,6 +184,8 @@ struct pxa_i2c {
> >  #define _ICR(i2c)	((i2c)->reg_icr)
> >  #define _ISR(i2c)	((i2c)->reg_isr)
> >  #define _ISAR(i2c)	((i2c)->reg_isar)
> > +#define _ILCR(i2c)	((i2c)->reg_ilcr)
> > +#define _IWCR(i2c)	((i2c)->reg_iwcr)
> >  
> >  /*
> >   * I2C Slave mode address
> > @@ -467,11 +486,16 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
> >  	if (i2c->reg_isar)
> >  		writel(i2c->slave_addr, _ISAR(i2c));
> >  #endif
> > -
> Not in this patch.
> 
> >  	/* set control register values */
> >  	writel(I2C_ICR_INIT | (i2c->fast_mode ? ICR_FM : 0), _ICR(i2c));
> >  	writel(readl(_ICR(i2c)) | (i2c->high_mode ? ICR_HS : 0), _ICR(i2c));
> >  
> > +	if (i2c->ilcr)
> > +		writel(i2c->ilcr, _ILCR(i2c));
> > +	if (i2c->iwcr)
> > +		writel(i2c->iwcr, _IWCR(i2c));
> > +	udelay(2);
> This is a magical 2us. Where does it come from ?

  This delay can be removed, if writing LCR and WCR before enabling this
  i2c controller, it's safe enough; and they should not be changed when
  there is bus activity.
> 
> Cheers.
> 
> -- 
> Robert
