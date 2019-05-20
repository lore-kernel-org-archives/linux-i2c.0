From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v5 3/3] i2c-ocores: sifive: add polling mode workaround
 for FU540-C000 SoC.
Date: Mon, 20 May 2019 16:52:16 +0200
Message-ID: <20190520145216.GD22024@lunn.ch>
References: <1558361478-4381-1-git-send-email-sagar.kadam@sifive.com>
 <1558361478-4381-4-git-send-email-sagar.kadam@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1558361478-4381-4-git-send-email-sagar.kadam@sifive.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, peter@korsgaard.com, palmer@sifive.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-i2c@vger.kernel.org, paul.walmsley@sifive.com, linux-riscv@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

On Mon, May 20, 2019 at 07:41:18PM +0530, Sagar Shrikant Kadam wrote:
> The i2c-ocore driver already has a polling mode interface.But it needs
> a workaround for FU540 Chipset on HiFive unleashed board (RevA00).
> There is an erratum in FU540 chip that prevents interrupt driven i2c
> transfers from working, and also the I2C controller's interrupt bit
> cannot be cleared if set, due to this the existing i2c polling mode
> interface added in mainline earlier doesn't work, and CPU stall's
> infinitely, when-ever i2c transfer is initiated.
> 
> Ref:previous polling mode support in mainline
> 
> 	commit 69c8c0c0efa8 ("i2c: ocores: add polling interface")
> 
> The workaround / fix under OCORES_FLAG_BROKEN_IRQ is particularly for
> FU540-COOO SoC.
> 
> Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>

Much better, thanks.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
