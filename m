From: Aaron Sierra <asierra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2  0/1] i2c-i801: utilize hardware semaphore
Date: Fri, 02 Nov 2012 14:22:44 -0500 (CDT)
Message-ID: <08fffed6-0883-4384-a689-c1e7bda3f5cc@zimbra>
References: <38634876-ca6c-499a-9da0-05c950a72c01@zimbra>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <38634876-ca6c-499a-9da0-05c950a72c01@zimbra>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Eudean Sun <eudean-BGArkANP9klv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

v2: ran through checkpatch.pl:
  - fixed a line of spaces at the beginning of the line (Thanks Eudean)
  - replaced msleep(1) with usleep_range(1000, 3000)
