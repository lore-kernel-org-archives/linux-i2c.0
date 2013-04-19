From: Bryan O'Donoghue <bryan.odonoghue.lkml@nexus-software.ie>
Subject: Re: [PATCH] i2c-designware: fix RX FIFO overrun
Date: Fri, 19 Apr 2013 21:43:41 +0100
Message-ID: <5171AC7D.70503@nexus-software.ie>
References: <alpine.DEB.2.02.1304191859570.17829@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1304191859570.17829@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Josef Ahmad <josef.ahmad@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Ben Dooks <ben-linux@fluff.org>, Jean Delvare <khali@linux-fr.org>, Stefan Roese <sr@denx.de>, Axel Lin <axel.lin@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Dirk Brandewie <dirk.brandewie@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Josef.

This fixes a real bug for us does it not, some failure case with a 
sustained amount of traffic ?


Bryan
