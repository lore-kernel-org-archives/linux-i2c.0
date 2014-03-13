From: Yuan Yao <yao.yuan@freescale.com>
Subject: [PATCH v3 0/2] i2c: add DMA support for freescale i2c driver
Date: Thu, 13 Mar 2014 09:47:55 +0800
Message-ID: <1394675277-24913-1-git-send-email-yao.yuan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: wsa@the-dreams.de, marex@denx.de
Cc: mark.rutland@arm.com, shawn.guo@linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


Changed in v3:
- fix a bug when request the dma faild.
- some minor fixes for coding style.
- other minor fixes.

Changed in v2:
- remove has_dma_support property
- unify i2c_imx_dma_rx and i2c_imx_dma_tx
- unify i2c_imx_dma_read and i2c_imx_pio_read
- unify i2c_imx_dma_write and i2c_imx_pio_write

Added in v1:
- Enable dma if it's support dma and transfer size bigger than the threshold.
- Add device tree bindings for i2c eDMA support.
- Add eDMA support for i2c driver.
