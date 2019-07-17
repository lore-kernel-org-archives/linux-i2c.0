From: Qii Wang <qii.wang@mediatek.com>
Subject: Re: [PATCH 1/2] dt-bindings: i2c: Add MediaTek i2c AC timing binding
Date: Wed, 17 Jul 2019 20:55:21 +0800
Message-ID: <1563368121.16970.7.camel@mhfsdcap03>
References: <1560240715-22595-1-git-send-email-qii.wang@mediatek.com>
 <1560240715-22595-2-git-send-email-qii.wang@mediatek.com>
 <20190626133941.GL801@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190626133941.GL801@ninjato>
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
Cc: devicetree@vger.kernel.org, srv_heupstream@mediatek.com, leilk.liu@mediatek.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 2019-06-26 at 15:39 +0200, Wolfram Sang wrote:
> Hi,
> 
> On Tue, Jun 11, 2019 at 04:11:54PM +0800, Qii Wang wrote:
> > Add i2c AC timing binding to binding file. It can give the AC
> > timing parameters to meet I2C specification at different speed.
> > 
> > Signed-off-by: Qii Wang <qii.wang@mediatek.com>
> 
> I think this is a too specific 1:1 mapping of your register set into DT
> world. We already have these generic parameters:
> 
> - clock-frequency
>         frequency of bus clock in Hz.
> 
> - i2c-scl-falling-time-ns
>         Number of nanoseconds the SCL signal takes to fall; t(f) in the I2C
>         specification.
> 
> - i2c-scl-internal-delay-ns
>         Number of nanoseconds the IP core additionally needs to setup SCL.
> 
> - i2c-scl-rising-time-ns
>         Number of nanoseconds the SCL signal takes to rise; t(r) in the I2C
>         specification.
> 
> - i2c-sda-falling-time-ns
>         Number of nanoseconds the SDA signal takes to fall; t(f) in the I2C
>         specification.
> 
> (check Documentation/devicetree/bindings/i2c/i2c.txt)
> 
> Can't you use those to derive your values from that? Which ones are you missing
> if not?
> 
> Regards,
> 
>    Wolfram

I have take a little time to develop a new patch which based on your
suggestions, and it tested OK. Thanks for your suggestions, I will
update the patch after I test it fully.
