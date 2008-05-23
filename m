From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] i2c: Push ioctl BKL down into the i2c code
Date: Fri, 23 May 2008 10:46:30 +0200
Message-ID: <48368466.5040600@s5r6.in-berlin.de>
References: <20080522222327.1af72794@core> <20080523093545.175c769c@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756065AbYEWIsT@vger.kernel.org>
In-Reply-To: <20080523093545.175c769c@hyperion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Jean Delvare wrote:
> On Thu, 22 May 2008 22:23:27 +0100, Alan Cox wrote:
>> Signed-off-by: Alan Cox <alan@redhat.com>
>> 
> 
> Description of what the patch does and why it is needed, please. I
> can't apply it without that. My first impression is a patch making the
> code bigger and more complex with no obvious benefit ;)

I wasn't asked, but:

The patch description was factored out.  ;-)
http://lkml.org/lkml/2008/5/22/333

AFAIU it's a preparation for

--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ ?? @@ struct file_operations {
 	unsigned int (*poll) (struct file *, struct poll_table_struct *);
-	int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
 	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);

Obvious benefits:
  - No new .ioctl()s.
  - Heads up for subsystem people:  "Did you know you are taking the BKL?
    You probably don't need to, and you definitely don't want to."
-- 
Stefan Richter
-=====-==--- -=-= =-===
http://arcgraph.de/sr/
