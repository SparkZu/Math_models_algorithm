#include <iostream>
#include <vector>
#include <cstring>
#include <algorithm>
using namespace std;
// Ford-Fulkerson algorithm
//寻找路径
//找min
//原减min
//增加反向路径
int max_flow_sum = 0;
const int N = 5;
int a[N][N];
int size;
int path[N * N + 10];
bool vis[N];
bool flag = true;
bool need = true;
vector<int> v;
void init_map()
{
    a[0][1] = 100;
    a[0][2] = 100;
    a[0][3] = 100;
    a[1][4] = 100;
    a[2][4] = 100;
    a[3][4] = 100;
    a[1][2] = 1;
    a[2][3] = 1;
}
void dfs(int x, int step)
{
    if (x == N - 1)
    {
        path[step] = x;
        if (need)
        {
            size = step;
            for (int i = 0; i <= size; i++)
            {
                printf("%d", path[i]);
                v.push_back(path[i]);
            }
            printf("\n");
            need = false;
            flag = true;
        }
        return;
    }
    else
    {
        for (int i = 0; i < N; i++)
        {
            if (a[x][i] > 0 && vis[i] == false)
            {
                vis[i] = true;
                path[step + 1] = i;
                dfs(i, step + 1);
                if (need == false)
                {
                    return;
                }
                vis[i] = false;
            }
        }
    }
    flag = false;
    return;
}
void update_a()
{
    vector<int> count_min;
    for (auto cur = v.begin(); cur != v.end() - 1; cur++)
    {
        count_min.push_back(a[*cur][*(cur + 1)]);
    }
    int min_all = *min_element(count_min.begin(), count_min.end());
    for (auto cur = v.begin(); cur != v.end() - 1; cur++)
    {
        a[*cur][*(cur + 1)] -= min_all;
        a[*(cur + 1)][*cur] += min_all;
    }
    max_flow_sum += min_all;
}
int main()
{
    init_map();
    while (flag)
    {
        need = true;
        v.clear();
        memset(vis, false, sizeof vis);
        vis[0] = true;
        path[0] = 0;
        dfs(0, 0);
        if (flag)
            update_a();
    }
    printf("%d", max_flow_sum);
    return 0;
}