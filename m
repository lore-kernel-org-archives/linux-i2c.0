From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 2/5] i2c:ocores: do not handle IRQ if IF is not set
Date: Fri, 8 Feb 2019 18:00:03 +0100
Message-ID: <20190208170003.GB1853@lunn.ch>
References: <20190208161201.7860-1-federico.vaga@cern.ch>
 <20190208161201.7860-3-federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190208161201.7860-3-federico.vaga@cern.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Federico Vaga <federico.vaga@cern.ch>
Cc: Peter Korsgaard <peter@korsgaard.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Feb 08, 2019 at 05:11:58PM +0100, Federico Vaga wrote:
> If the Interrupt Flag (IF) is not set, we should not handle the IRQ:
> - the line can be shared with other devices
> - it can be a spurious interrupt
> 
> To avoid reading twice the status register, the ocores_process() function
> expects it to be read by the caller.
> 
> Signed-off-by: Federico Vaga <federico.vaga@cern.ch>
> Acked-by: Peter Korsgaard <peter@korsgaard.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
