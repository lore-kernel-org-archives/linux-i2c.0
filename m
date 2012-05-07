From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V1 1/2] i2c: tegra: make all resource allocation through
 devm_*
Date: Mon, 07 May 2012 10:18:45 -0600
Message-ID: <4FA7F5E5.4070609@wwwdotorg.org>
References: <1336373179-12739-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1336373179-12739-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, olof@lixom.net, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 05/07/2012 12:46 AM, Laxman Dewangan wrote:
> Use the devm_* for the memory region allocation, interrupt request,
> clock handler request.
> By doing this, it does not require to explicitly free it and hence
> saving some code.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>

Acked-by: Stephen Warren <swarren@wwwdotorg.org>

Note thought that devm_clk_get() appears to have been introduced very
recently in linux-next, so in order to merge this patch one of the
following has to happen:

a) This patch goes through the tree that merged the addition of
devm_clk_get() (which I think is Russell King's ARM tree)

b) Whichever tree takes this patch must first merge a branch that
contains that patch that adds devm_clk_get().
