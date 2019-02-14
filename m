From: Qii Wang <qii.wang@mediatek.com>
Subject: Re: [PATCH v3 5/6] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Date: Thu, 14 Feb 2019 09:54:28 +0800
Message-ID: <1550109268.30065.13.camel@mhfsdcap03>
References: <1548057574-8061-1-git-send-email-qii.wang@mediatek.com>
         <1548057574-8061-6-git-send-email-qii.wang@mediatek.com>
         <20190205131641.GF12401@kunai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190205131641.GF12401@kunai>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, leilk.liu@mediatek.com, ryder.lee@mediatek.com, xinping.qian@mediatek.com, liguo.zhang@mediatek.com
List-Id: linux-i2c@vger.kernel.org

On Tue, 2019-02-05 at 14:16 +0100, Wolfram Sang wrote:
> > +  - mediatek,share-i3c: i3c controller can share i2c function.
> 
> I am not happy with this binding. There must be a better way of using
> the I3C controller in I2C mode. I think it would be easier to tell if we
> had an I3C driver to see how it implements I2C fallback there. Is the
> I3C driver on the way?
> 

I am very sorry for the late reply due to the Chinese New Year holiday.
After confirmation, for I2C mode in I3C controller, we will push an I3C
driver to implement I2C fallback there later, and we will remove
"mediatek,share-i3c" for i2c controller driver in the next patch.
