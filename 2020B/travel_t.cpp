#include <iostream>
#include <cstring>
#include <map>

using namespace std;

map<pair<int, int>, bool> mp;

const int qua[4] = {0, 1, 2, 3}; // 0:起点 1：村庄 2：矿山 3：终点
const int dist[4][4] = {{0, 6, 8, 3}, {6, 0, 2, 3}, {8, 2, 0, 5}, {3, 3, 5, 0}};
const int f[4][4] = {{0, 1, 1, 1}, {0, 0, 1, 1}, {0, 1, 0, 1}, {0, 0, 0, 0}};
const int wea[30] = {2, 2, 1, 3, 1, 2, 3, 1, 2, 2, 3, 2, 1, 2, 2, 2, 3, 3, 2, 2, 1, 1, 2, 1, 3, 2, 1, 1, 2, 2};
const int wx = 3;                //水
const int wy = 2;                // food
const int cx = 5;                //水价格
const int cy = 10;               // food价格
const int sx[4] = {0, 5, 8, 10}; // 1-3分别晴朗，高温，沙暴
const int sy[4] = {0, 7, 6, 10};
const int n = 4;
const int maxm = 1200; //最大重量
const int coins = 10000;
const int base = 1000;
const int date = 30;
int costx[32][4][4];
int costy[32][4][4];
int days[32][4][4];
int ans = 0;
int rec[32];
int action[32];
int ansx[32];   //最优解路径
int ansact[32]; //最优策略
int ansg, ansh; //对应初始水与食物资源量
int g, h;       //用于枚举的初始水与食物资源
void dfs(int day, int now, int nm, int c, int x, int y, int type)
{
    action[day] = type;
    rec[day] = now;
    if (qua[now] == 3)
    {
        if (ans <= c + x * cx + y * cy)
        {
            ansg = g;
            ansh = h;
            ans = c + x * cx + y * cy;
            for (int i = 0; i <= date; i++)
                ansx[i] = rec[i];
            for (int i = 0; i <= date; i++)
                ansact[i] = action[i];
        }
        action[day] = -1;
        rec[day] = -1;
        return;
    }
    if (day >= date)
    {
        action[day] = -1;
        rec[day] = -1;
        return;
    }
    if (qua[now] == 1)
        nm = maxm - wx * x - wy * y;
    for (int i = 0; i < n; i++)
    {
        if (f[qua[now]][qua[i]])
        {
            int tx = costx[day][now][i];
            int ty = costy[day][now][i];
            int ucost = c;
            int ux, uy;
            int um = nm;
            if (x >= tx)
            {
                ux = x - tx;
            }
            else
            {
                ux = 0;
                ucost -= 2 * (tx - x) * cx;
                um -= (tx - x) * wx;
            }

            if (y >= ty)
            {
                uy = y - ty;
            }
            else
            {
                uy = 0;
                ucost -= 2 * (ty - y) * cy;
                um -= (ty - y) * wy;
            }
            if (ucost < 0 || um < 0)
            {
                continue;
            }
            dfs(day + days[day][now][i], i, um, ucost, ux, uy, 0);
        }
    }
    if (qua[now] == 2)
    {
        int attday = day;
        int tx = sx[wea[attday]];
        int ty = sy[wea[attday]];
        attday++;

        if (x >= tx)
        {
            x -= tx;
            tx = 0;
        }
        else
        {
            tx -= x;
            x = 0;
        }
        if (y >= ty)
        {
            y -= ty;
            ty = 0;
        }
        else
        {
            ty -= y;
            y = 0;
        }
        nm -= tx * wx + ty * wy;
        c -= 2 * tx * cx + 2 * ty * cy;
        if (nm >= 0 && c >= 0)
        {
            dfs(attday, now, nm, c, x, y, 1);
        }
        attday = day;
        tx = sx[wea[attday]] * 2;
        ty = sy[wea[attday]] * 2;
        attday++;
        if (x >= tx)
        {
            x -= tx;
            tx = 0;
        }
        else
        {
            tx -= x;
            x = 0;
        }
        if (y >= ty)
        {
            y -= ty;
            ty = 0;
        }
        else
        {
            ty -= y;
            y = 0;
        }
        nm -= tx * wx + ty * wy;
        c -= 2 * tx * cx + 2 * ty * cy;
        c += base;
        if (nm >= 0 && c >= 0)
        {
            dfs(attday, now, nm, c, x, y, 2);
        }
    }
    rec[day] = -1;
    action[day] = -1;
}
int main()
{
    // memset(rec, -1, sizeof rec);
    // memset(action, -1, sizeof action);
    for (int d = 0; d <= date; d++)
    {
        rec[d] = -1;
        action[d] = -1;
    }
    for (int d = 0; d < date; d++)
        for (int i = 0; i < n; i++)
            for (int j = 0; j < n; j++)
                if (f[qua[i]][qua[j]])
                {
                    int now = 0, count = 0, sumx = 0, sumy = 0;
                    while (count < dist[i][j])
                    {
                        if (wea[now + d] != 3)
                        {
                            count++;
                            sumx += 2 * sx[wea[now + d]];
                            sumy += 2 * sx[wea[now + d]];
                        }
                        else
                        {
                            sumx += sx[wea[now + d]];
                            sumy += sy[wea[now + d]];
                        }
                        now++;
                        if (now + d >= date)
                        {
                            break;
                        }
                    }
                    if (count < dist[i][j])
                    {
                        sumx = sumy = 20000;
                        now = 30;
                    }
                    costx[d][i][j] = sumx;
                    costy[d][i][j] = sumy;
                    days[d][i][j] = now;
                }
    for (int i = 0; i <= maxm; i++)
    {
        g = i / wx;
        h = (maxm - i) / wy;
        if (!mp[make_pair(g, h)])
            dfs(0, 0, 0, coins - g * cx - h * cy, g, h, -1);
        mp[make_pair(g, h)] = 1;
    }
    for (int i = 0; i <= date; i++)
        cout << i << " " << ansx[i] << ";" << ansact[i] << endl;
    cout << endl;
    cout << ans << " " << ansg << " " << ansh << endl;
}