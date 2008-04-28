From: Jean Delvare <khali@linux-fr.org>
Subject: Re: i2c or eeprom enumeration problem
Date: Mon, 28 Apr 2008 16:21:23 +0200
Message-ID: <20080428162123.7fd8eb04@hyperion.delvare>
References: <4815509A.9040802@redhat.com>
	<20080428050515.fcc05689.akpm@linux-foundation.org>
	<20080428141526.2f4e993f@hyperion.delvare>
	<4815DC52.1050908@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934767AbYD1OWV@vger.kernel.org>
In-Reply-To: <4815DC52.1050908@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulrich Drepper <drepper@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 28 Apr 2008 07:16:50 -0700, Ulrich Drepper wrote:
> Jean Delvare wrote:
> > Motherboard manufacturer and model?
> 
> Tyan S4985.  It's a quad socket, quad core AMD system.

OK. Maybe it uses the same trick as the S4882... Can you get the
information from Tyan?

Please provide the output of i2cdetect for all the SMBus channels.

-- 
Jean Delvare
