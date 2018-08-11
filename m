From: Federico Vaga <federico.vaga@cern.ch>
Subject: Re: i2c:ocores: fixes and polling mechanism
Date: Sat, 11 Aug 2018 19:13:54 +0200
Message-ID: <5011687.103nMUzm2u@harkonnen>
References: <20180625161303.7991-1-federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180625161303.7991-1-federico.vaga@cern.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Peter Korsgaard <jacmet@sunsite.dk>
List-Id: linux-i2c@vger.kernel.org

Hello,

sorry to disturb you all but after one month and a half I never received 
any comment about this patch set and I fear it ended up in a forgotten 
corner. I would like to know if someone is considering it or not.

Thanks :)

On Monday, June 25, 2018 6:13:00 PM CEST Federico Vaga wrote:
> The first two patches fix what I believe are bugs.
> 
> The third patch add a polling mechanism for those systems where
> interrupts are not available.
> 
> All these patches have been tested on a system without interrupt, this
> means that I used my third patch to validate also the other two.
> I would be nice if someone can run verify this also on other system,
> perhaps with interrupts. If you consider it a useful information, I'm not
> using devicetree for this installation.


-- 
Federico Vaga
[BE-CO-HT]
