From: Federico Vaga <federico.vaga@cern.ch>
Subject: i2c:ocores: fixes and polling mechanism
Date: Mon, 25 Jun 2018 18:13:00 +0200
Message-ID: <20180625161303.7991-1-federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Korsgaard <jacmet@sunsite.dk>
Cc: federico.vaga@cern.ch
List-Id: linux-i2c@vger.kernel.org

The first two patches fix what I believe are bugs.

The third patch add a polling mechanism for those systems where interrupts
are not available.

All these patches have been tested on a system without interrupt, this
means that I used my third patch to validate also the other two.
I would be nice if someone can run verify this also on other system,
perhaps with interrupts. If you consider it a useful information, I'm not
using devicetree for this installation.
