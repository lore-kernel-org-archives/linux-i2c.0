From: Qii Wang <qii.wang@mediatek.com>
Subject: Re: [PATCH v3 5/6] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Date: Sat, 16 Feb 2019 19:32:03 +0800
Message-ID: <1550316723.30065.44.camel@mhfsdcap03>
References: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
 <1548057574-8061-6-git-send-email-qii.wang@mediatek.com>
 <20190205131641.GF12401@kunai> <1550109268.30065.13.camel@mhfsdcap03>
 <20190215090257.geumssb2cucs7rzt@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190215090257.geumssb2cucs7rzt@ninjato>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: devicetree@vger.kernel.org, ryder.lee@mediatek.com, srv_heupstream@mediatek.com, Rob Herring <robh@kernel.org>, leilk.liu@mediatek.com, xinping.qian@mediatek.com, linux-kernel@vger.kernel.org, liguo.zhang@mediatek.com, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 2019-02-15 at 10:02 +0100, Wolfram Sang wrote:
> On Thu, Feb 14, 2019 at 09:54:28AM +0800, Qii Wang wrote:
> > On Tue, 2019-02-05 at 14:16 +0100, Wolfram Sang wrote:
> > > > +  - mediatek,share-i3c: i3c controller can share i2c function.
> > > 
> > > I am not happy with this binding. There must be a better way of using
> > > the I3C controller in I2C mode. I think it would be easier to tell if we
> > > had an I3C driver to see how it implements I2C fallback there. Is the
> > > I3C driver on the way?
> > > 
> > 
> > I am very sorry for the late reply due to the Chinese New Year holiday.
> 
> No worries. I hope you enjoyed the holidays!
> 
> > After confirmation, for I2C mode in I3C controller, we will push an I3C
> > driver to implement I2C fallback there later, and we will remove
> > "mediatek,share-i3c" for i2c controller driver in the next patch.
> 
> The problem with DT bindings is that you need to support them forever
> once you introduced them. Because there might be old device trees on
> boards out there which need the property. So, I don't like the idea of
> having a temporary binding which is meant to be removed anyway. My take
> is that you should just send out the I3C driver which will handle the
> I2C support then.
> 
> Adding Rob to CC in case he has a different opinion.
> 

Maybe you think that MT8183 SoC only has the I3C controllers. Actually,
there are I2C and I3C controllers on MT8183 SoC. We will remove
"mediatek,share-i3c" for I2C controller driver, so these patches are
just to support the I2C controllers on MT8183 SoC. For the I3C
controller we will send some new patches which are based on i3c
framework directories(kernel/drivers/i3c), not based on
i2c-mt65xx.c.
