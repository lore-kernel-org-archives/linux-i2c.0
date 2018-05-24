From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] i2c-mux-reg: Delete an error message for a failed memory
 allocation in i2c_mux_reg_probe_dt()
Date: Thu, 24 May 2018 14:00:21 +0200
Message-ID: <480df169-84e5-8c0a-475a-edd4bf688e66@axentia.se>
References: <224a8918-f882-9ab1-218c-83df93d4cb2f@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <224a8918-f882-9ab1-218c-83df93d4cb2f@users.sourceforge.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, York Sun <yorksun@freescale.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Alexander Sverdlin <alexander.sverdlin@nokia.com>
List-Id: linux-i2c@vger.kernel.org

On 2018-02-01 17:24, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 1 Feb 2018 17:17:19 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied to i2c-mux/for-next with a shortened subject.

Cheers,
Peter
