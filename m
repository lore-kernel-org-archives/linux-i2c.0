From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] i2c: i2c-sh_mobile irq rollback fix
Date: Wed, 4 Aug 2010 16:44:01 +0900
Message-ID: <20100804074401.GC15098@linux-sh.org>
References: <20100802071637.18054.76993.sendpatchset@t400s>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100802071637.18054.76993.sendpatchset@t400s>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-i2c@vger.kernel.org, khali@linux-fr.org, linux-sh@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Aug 02, 2010 at 04:16:37PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Update the i2c-sh_mobile driver to properly free
> interrupts. The function sh_mobile_i2c_hook_irqs()
> is fixed so module both unload and load are working
> as expected.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Applied, thanks.
