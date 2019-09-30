From: Cengiz Can <cengiz@kernel.wtf>
Subject: Re: [PATCH v2] i2c: i2c-mt65xx: fix NULL ptr dereference
Date: Tue, 01 Oct 2019 00:20:50 +0300
Message-ID: <aa0487c21e1f9f04402f209358b18c75@kernel.wtf>
References: <20190930152846.5062-1-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190930152846.5062-1-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Parent <fparent@baylibre.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, matthias.bgg@gmail.com, wsa@the-dreams.de, qii.wang@mediatek.com, drinkcat@chromium.org, hsinyi@chromium.org, tglx@linutronix.de, linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 2019-09-30 18:28, Fabien Parent wrote:
> Fixes: abf4923e97c3 ("i2c: mediatek: disable zero-length transfers for 
> mt8183")
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Reviewed-by: Cengiz Can <cengiz@kernel.wtf>
