From: matthias@kaehlcke.net
Subject: [patch 0/2] i2c-core.c: use list_for_each_entry_safe()
Date: Mon, 19 May 2008 22:48:38 +0200
Message-ID: <20080519204838.612046856@kaehlcke.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763284AbYESUvA@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: khali@linux-fr.org, i2c@lm-sensors.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-i2c@vger.kernel.org

i2c-core.c: use list_for_each_entry_safe() in i2c_del_adapter() and i2c_del_driver()

-- 
Matthias Kaehlcke
Embedded Linux Engineer
Barcelona

              We build too many walls and not enough bridges
                             (Isaac Newton)
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-
