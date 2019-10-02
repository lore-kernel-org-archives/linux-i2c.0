From: Ulrich Hecht <uli@fpond.eu>
Subject: Re: [PATCH v2] i2c: i2c-mt65xx: fix NULL ptr dereference
Date: Wed, 2 Oct 2019 10:43:55 +0200 (CEST)
Message-ID: <1733244772.936156.1570005835848@webmail.strato.com>
References: <20190930152846.5062-1-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190930152846.5062-1-fparent@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fabien Parent <fparent@baylibre.com>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: drinkcat@chromium.org, wsa@the-dreams.de, hsinyi@chromium.org, matthias.bgg@gmail.com, tglx@linutronix.de, qii.wang@mediatek.com
List-Id: linux-i2c@vger.kernel.org


> On September 30, 2019 at 5:28 PM Fabien Parent <fparent@baylibre.com> wrote:
> 
> 
> Since commit abf4923e97c3 ("i2c: mediatek: disable zero-length transfers
> for mt8183"), there is a NULL pointer dereference for all the SoCs
> that don't have any quirk. mtk_i2c_functionality is not checking that
> the quirks pointer is not NULL before starting to use it.
> 
> This commit add a call to i2c_check_quirks which will check whether
> the quirks pointer is set, and if so will check if the IP has the
> NO_ZERO_LEN quirk.
> 
> Fixes: abf4923e97c3 ("i2c: mediatek: disable zero-length transfers for mt8183")
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Thank you! Tested successfully on Acer R13 Chromebook (mt8173).

Tested-by: Ulrich Hecht <uli@fpond.eu>

CU
Uli
