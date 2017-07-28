From: Brendan Higgins <brendanhiggins@google.com>
Subject: [PATCH v2 0/1] i2c: aspeed: add proper support fo 24xx clock params
Date: Fri, 28 Jul 2017 13:45:57 -0700
Message-ID: <20170728204558.6455-1-brendanhiggins@google.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de, benh@kernel.crashing.org, joel@jms.id.au, rburanyi@google.com
Cc: linux-i2c@vger.kernel.org, openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

This fixes a minor issue pointed out by Robi <rburanyi@google.com> and also adds
a couple improvements that he suggested outside of the mailing list.

Tested on the Aspeed 2500.
