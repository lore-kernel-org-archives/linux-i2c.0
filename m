From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH v2] i2c: cadence: fixup of wait_for_completion_timeout
 return handling
Date: Mon, 9 Feb 2015 08:15:59 -0800
Message-ID: <0031e482e8bd435b92a52cb3ef66e56e@BY2FFO11FD025.protection.gbl>
References: <1423494232-24747-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423494232-24747-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Michal Simek <michal.simek@xilinx.com>, Wolfram Sang <wsa@the-dreams.de>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 2015-02-09 at 10:03AM -0500, Nicholas Mc Guire wrote:
> return type of wait_for_completion_timeout is unsigned long not int. The
> return variable is renamed to reflect its use and the type adjusted to
> unsigned long.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Reviewed-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

	Soren
