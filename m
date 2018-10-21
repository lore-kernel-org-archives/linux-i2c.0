From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 2/3] i2c:ocores: do not handle IRQ if IF is not set
Date: Sun, 21 Oct 2018 16:12:10 +0200
Message-ID: <CACXmViZZ3SBPbV4AXK6EsJPfD5TJqEU_-Q36+vz5LxTk_pzq4A@mail.gmail.com>
References: <20180625161303.7991-1-federico.vaga@cern.ch> <20180625161303.7991-3-federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180625161303.7991-3-federico.vaga@cern.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Federico Vaga <federico.vaga@cern.ch>
Cc: linux-i2c <linux-i2c@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jun 25, 2018 at 6:14 PM Federico Vaga <federico.vaga@cern.ch> wrote:
>
> If the Interrupt Flag (IF) is not set, we should not handle the IRQ:
> - the line can be shared with other devices
> - it can be a spurious interrupt
>
> To avoid reading twice the status register, the ocores_process() function
> expects it to be read by the caller.
>
> Signed-off-by: Federico Vaga <federico.vaga@cern.ch>

Looks good.

Acked-by: Peter Korsgaard <peter@korsgaard.com>

-- 
Bye, Peter Korsgaard
